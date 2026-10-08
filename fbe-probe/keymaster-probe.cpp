// Recovery diagnosis only. Never prints key material or writes key files.
#include <android-base/file.h>
#include <android/hardware/keymaster/4.0/IKeymasterDevice.h>
#include <openssl/sha.h>
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>
using namespace android::hardware;
namespace km = android::hardware::keymaster::V4_0;
int main() {
    std::string blob, sec;
    if (!android::base::ReadFileToString("/data/unencrypted/key/keymaster_key_blob", &blob)
        || !android::base::ReadFileToString("/data/unencrypted/key/secdiscardable", &sec)) return 2;
    if (blob.size() < 8 || memcmp(blob.data(), "pKMblob\0", 8) != 0) return 3;
    std::string prefix = "Android secdiscardable SHA512";
    prefix.resize(SHA512_CBLOCK);
    unsigned char appid[SHA512_DIGEST_LENGTH];
    SHA512_CTX ctx;
    SHA512_Init(&ctx);
    SHA512_Update(&ctx, prefix.data(), prefix.size());
    SHA512_Update(&ctx, sec.data(), sec.size());
    SHA512_Final(appid, &ctx);
    auto device = km::IKeymasterDevice::getService();
    if (!device) return 4;
    hidl_vec<uint8_t> raw, app;
    raw.setToExternal(reinterpret_cast<uint8_t*>(&blob[8]), blob.size()-8);
    app.setToExternal(appid, sizeof(appid));
    int result = 5;
    auto status = device->getKeyCharacteristics(raw, app, {}, [&](km::ErrorCode code, const km::KeyCharacteristics&) {
        printf("hardware_characteristics_error=%d\n", static_cast<int>(code));
        result = code == km::ErrorCode::OK ? 0 : 1;
    });
    if (!status.isOk()) { puts("hardware_transaction_failed"); return 6; }
    memset(appid, 0, sizeof(appid));
    return result;
}

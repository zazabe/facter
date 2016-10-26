#include <facter/util/config.hpp>
#include <leatherman/windows/file_util.hpp>

namespace facter { namespace util { namespace config {

    hocon::shared_config load_default_config_file() {
        return load_config_from(default_config_location());
    }

    std::string default_config_location() {
        return leatherman::windows::file_util::get_programdata_dir() +
            "\\PuppetLabs\\facter\\etc\\facter.conf";
    }
}}}  // namespace facter::util::config

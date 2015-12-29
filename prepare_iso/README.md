## Preparing the ISO

> This script is pulled from [timsutton/osx-vm-templates](https://raw.githubusercontent.com/timsutton/osx-vm-templates)

OS X's installer cannot be bootstrapped as easily as can Linux or Windows, and so exists the [prepare_iso.sh](https://github.com/timsutton/osx-vm-templates/blob/master/prepare_iso/prepare_iso.sh) script to perform modifications to it that will allow for an automated install and ultimately allow Packer and later, Vagrant, to have SSH access.

**Note:** VirtualBox users currently have to disable Remote Management to avoid [periodic freezing](https://github.com/timsutton/osx-vm-templates/issues/43) of the VM by adding `-D DISABLE_REMOTE_MANAGEMENT` to the `prepare_iso.sh` options. See [Remote Management freezing issue](#remote-management-freezing-issue) for more information.

Run the `prepare_iso.sh` script with two arguments: the path to an `Install OS X.app` or the `InstallESD.dmg` contained within, and an output directory. Root privileges are required in order to write a new DMG with the correct file ownerships. For example, with a 10.8.4 Mountain Lion installer:

`sudo prepare_iso/prepare_iso.sh "/Applications/Install OS X Mountain Lion.app" out`

...should output progress information ending in something this:

```
-- MD5: dc93ded64396574897a5f41d6dd7066c
-- Done. Built image is located at out/OSX_InstallESD_10.8.4_12E55.dmg. Add this iso and its checksum to your template.
```

`prepare_iso.sh` accepts command line switches to modify the details of the admin user installed by the script.

* `-u` modifies the name of the admin account, defaulting to `vagrant`
* `-p` modifies the password of the same account, defaulting to `vagrant`
* `-i` sets the path of the account's avatar image, defaulting to `prepare_iso/support/vagrant.jpg`

For example:

`sudo prepare_iso/prepare_iso.sh -u admin -p password -i /path/to/image.jpg "/Applications/Install OS X Mountain Lion.app" out`

Additionally, flags can be set to disable certain default configuration options.

* `-D DISABLE_REMOTE_MANAGEMENT` disables the Remote Management service.
* `-D DISABLE_SCREEN_SHARING` disables the Screen Sharing service.

#### Clone this repository

The `prepare_iso.sh` script needs the `support` directory and its content. In other words, the easiest way to run the script is after cloning this repository.

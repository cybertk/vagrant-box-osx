export ISO_URL=~/Downloads/OSX_InstallESD_10.11.4_15E65.iso
export ISO_CHECKSUM=117241ad58b202d98e12653526614ef71f0d59ae8df06ddd021df55d6fc89593
packer validate el-capitan/template.json
packer build el-capitan/template.json

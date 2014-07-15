#!/bin/bash
path="/home/kvm/src/linux-3.14.10"
echo "1.rmmod kvm_intel kvm\n"
rmmod kvm-intel
rmmod kvm
echo "success!\n"
echo "2.rm kvm-intel.ko kvm.ko\n"
rm /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm.ko
rm /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm-intel.ko
echo "success!\n"
echo "3.make clean kvm module\n"
make clean CONFIG_KVM=m CONFIG_INTEL_KVM=m -C ${path} M=${path}/arch/x86/kvm
echo "success!\n"
echo "4.make kvm module"
make CONFIG_KVM=m CONFIG_INTEL_KVM=m -C ${path} M=${path}/arch/x86/kvm
echo "success!\n"
echo "5.insmod kvm-intel.ko kvm.ko\n"
cp ${path}/arch/x86/kvm/kvm-intel.ko /lib/modules/$(uname -r)/kernel/arch/x86/kvm/
cp ${path}/arch/x86/kvm/kvm.ko /lib/modules/$(uname -r)/kernel/arch/x86/kvm/
echo "success!\n"
echo "6.modprobe kvm_intel kvm"
modprobe kvm_intel
modprobe kvm
lsmod|grep kvm
ls -l /dev/kvm
echo "recompile and insmod kvm success!\n"

require 'spec_helper'
require 'mocha/api'
require 'vagrant-windows/guest/cap/mount_shared_folder'

describe VagrantWindows::Guest::Cap::MountSharedFolder, :unit => true do
  
  before(:each) do
    @communicator = mock()
    @machine = stub(:communicate => @communicator)
  end

  describe "mount_virtualbox_shared_folder" do
    it "should run script with vbox paths"  do
      @communicator.expects(:execute).with do |script, options|
        expect(script).to include("$VmProviderUncPath = \"\\\\vboxsrv\\vagrant\"")
      end      

      VagrantWindows::Guest::Cap::MountSharedFolder.mount_virtualbox_shared_folder(
        @machine, "vagrant", "/tmp/vagrant", {})
    end
  end
    
  describe "mount_vmware_shared_folder" do
    it "should run script with vmware paths"  do
      @communicator.expects(:execute).with do |script, options|
        expect(script).to include("$VmProviderUncPath = \"\\\\vmware-host\\Shared Folders\\vagrant\"")
      end
      
      VagrantWindows::Guest::Cap::MountSharedFolder.mount_vmware_shared_folder(
        @machine, "vagrant", "/tmp/vagrant", {})
    end
  end
 
  describe "mount_virtualbox_shared_folder_with_drive_letter" do
    it "should assign drive letter persistently in call to net use"  do
      @communicator.expects(:execute).with do |script, options|
        expect(script).to include("& net use X: $VmProviderUncPath /persistent:yes 2>&1 | out-null")
      end      

      VagrantWindows::Guest::Cap::MountSharedFolder.mount_virtualbox_shared_folder(
        @machine, "vagrant", "/tmp/vagrant", {:drive_letter => "X"})
    end
  end
 
  describe "mount_vmware_shared_folder_with_drive_letter" do
    it "should assign drive letter persistently in call to net use"  do
      @communicator.expects(:execute).with do |script, options|
        expect(script).to include("& net use X: $VmProviderUncPath /persistent:yes 2>&1 | out-null")
      end
      
      VagrantWindows::Guest::Cap::MountSharedFolder.mount_vmware_shared_folder(
        @machine, "vagrant", "/tmp/vagrant", {:drive_letter => "X"})
    end
  end

end

vsphere_vswitch_information = {
    name = "IhabSwitch",
    network_adapters = ["vmnic1"]
    active_nics = [ "vmnic1" ]
    standby_nics = [  ]
}

vsphere_port_list_group = ["group_ihab_1", "group_ihab_2", "group_ihab_3"]
vsphere_port_group_extra_group = true
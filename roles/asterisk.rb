name 'asterisk'
description 'Installs Asterisk to run Adhearsion apps'
run_list "recipe[asterisk]",
  "recipe[unimrcp]",
  "recipe[mojolingo-misc::mrcp_server_config]",
  "recipe[asterisk::unimrcp]"

override_attributes asterisk: {
  source: {
    version: '12.0.0',
    checksum: '0efc4507d5384447011fd1148eaaae2d06f70b04c736b4c73fbb9941a9440a2b',
  },
  sip: {
    context: 'adhearsion'
  },
  manager: {
    ip_address: '0.0.0.0',
    permit: '0.0.0.0/0.0.0.0',
    read_perms: %w{all},
    write_perms: %w{all},
    event_filters: ['!Event: RTCP*', '!Variable: RTPAUDIOQOS*']
  },
  unimrcp: {
    server_ip: '127.0.0.1',
    server_port: '8060',
    rtp_port_min: '5000',
    rtp_port_max: '6000',
    client_ip: '127.0.0.1',
    rtp_ip: '127.0.0.1'
  }
},
unimrcp: {
  install_flite: true,
  install_pocketsphinx: true
}

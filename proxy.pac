function FindProxyForURL(url, host) {
  if (isInNet(host, '192.168.66.0', '255.255.255.0')) {
    return 'SOCKS5 127.0.0.1:8888'
  }
  return 'DIRECT'
}

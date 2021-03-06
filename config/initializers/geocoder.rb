Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  # lookup: :google,            # name of geocoding service (symbol)
  lookup: :amap,
  # ip_lookup: :freegeoip,      # name of IP address geocoding service (symbol)
  ip_lookup: :baidu_ip,
  # language: :en,              # ISO-639 language code
  language: :zh,
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for geocoding service

  :baidu_ip=>{
    api_key: "C2s8ft3s77iu4y4ABo3ThFPvpPHEqZ0F", #baidu_ip
  },
  :baidu=>{
    api_key: "C2s8ft3s77iu4y4ABo3ThFPvpPHEqZ0F", #baidu map
  },
  :amap=> {
    api_key: "b9623a2eb0261d9d5453eb78e4c66f4e",
  }
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)

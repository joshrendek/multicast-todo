SuckerPunch.config do
  queue name: :broadcast, worker: MutlicastBroadcast, workers: 2
  queue name: :discovery, worker: MulticastDiscovery, workers: 2
end

# Docker Bitcoin SV

Building the docker image, naming it 'bitcoinsv':

```bash
docker build -t bitcoinsv .
```

By default bitcoin will put its data in `/root/.bitcoin/`, so we can mount a volume at that location instead. Running the image, naming the container 'bsv' and attaching a volume:

```bash
docker run -v ~/bitcoin/c:/root/.bitcoin --name bsv bitcoinsv
```

If we only want to mount a `bitcoind.conf` file we would use:

```bash
docker run -v ~/bitcoin/bitcoind.conf:/root/.bitcoin/bitcoind.conf --name bsv bitcoinsv
```

Now we should see the running container by running `docker ps -a`

To execute a command on the container:

```bash
docker exec -it bsv /bin/bash
```

Or to run standalone commands:

```bash
docker exec bsv /usr/local/bin/bitcoin-cli -regtest generate 101
docker exec bsv /usr/local/bin/bitcoin-cli -regtest getbalance
docker exec bsv /usr/local/bin/bitcoin-cli -regtest getnewaddress
docker exec bsv /usr/local/bin/bitcoin-cli -regtest sendtoaddress bchreg:qzyta9j7ntpceqf0cw8valn9u499xk60vctqt2j3pv 10.00
```

## Docker Compose

The docker compose file runs a miner and two nodes, named **miner**, **node1**, **node2**.

```bash
docker-compose up --build
```

To execute commands, same as the above but with the name of the docker compose container:

```bash
docker exec miner /usr/local/bin/bitcoin-cli -regtest generate 101
docker exec miner /usr/local/bin/bitcoin-cli -regtest getbalance
docker exec miner /usr/local/bin/bitcoin-cli -regtest getnewaddress
docker exec miner /usr/local/bin/bitcoin-cli -regtest sendtoaddress bchreg:qzyta9j7ntpceqf0cw8valn9u499xk60vctqt2j3pv 10.00
```

## References

- [Bitcoin multi node regtest](https://github.com/FreekPaans/bitcoin-multi-node-regtest)

# Spark Cluster Docker Stack with Apache AirFlow

Simple Docker cluster with a single master, single worker, a Zeppelin server and an AirFlow instance with a PostgreSQL backing store, using Ubuntu 16.04 as the base image.

There are two main docker images: spark and zeppelin, and the zeppelin image is just based on the spark image.

To build the images start at the project root:

```commandline
scripts/build_image.sh spark
scripts/build_image.sh zeppelin
scripts/build_image.sh airflow

```

It will take some time to build the images.
Once they are complete, bring up the stack:

```commandline
docker-compose up -d
```

You should have a 3-node Spark cluster with 1 master, 1 worker and 1 Zeppelin node.

The Zeppelin node exposes port 8000, so http://localhost:8000 should bring up the Zeppelin page.

The master Spark node exposes port 8080 where the management page can be found. The master node also exposes ports 4040, 6066 and 7077.

The worker node exposes port 8081.

The AirFlow node exposes port 8181, so http://localhost:8181 should bring up the AirFlow console.

To bring down the stack without losing your data

```commandline
docker-compose down
```

To bring down the stack and clean everything up

```commandline
docker-compose --remove-orphans -v
```
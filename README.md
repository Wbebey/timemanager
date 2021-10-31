# Time Manager

## List of folders

- frontend: Vue frontend
- backend: Elixir/Phoenix API
- local: Launch all applications in local environment

# Run

## locally

To run your applications locally you need to go to the */local/* folder then retreive the `.env` file in it.

---

The following commands are useful to know:

 - To build and start containers
```bash
docker-compose up
```
- To build container
```bash
docker-compose build
```
- To show running containers
```bash
docker ps 
```
- To show all local images
```bash
docker image ls 
```

# Test

## API 

 To test api url's, go to `backend/test/api` and run `./test_api.sh`

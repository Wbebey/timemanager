<template>
  <div>
    <h1>Ajouter une période de travail</h1>
    <div id="userid"><input type="number" class="input" min="1" /></div>
    <br />
    <div id="start">
      <label for="start-time">Arrivée:</label>

      <input type="datetime-local" id="start" />
    </div>
    <br />
    <div id="end">
      <label for="endtime">Départ:</label>

      <input type="datetime-local" id="end" />
    </div>
    <br />
    <div id="confirm-button">
      <button type="button" class="btn btn-primary">Confirmer</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "CreateWorkingTime",
  data() {
    return {
      info: null,
      start: null,
      end: null,
    };
  },
  methods: {
    createWorkingTime() {
      axios
        .post(
          "http://localhost:4000/api/workingtimes/" +
            this.user.userID +
            "?start=" +
            this.start +
            "&end=" +
            this.end
        )
        .then((response) => (this.info = response.data))
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
  },
};
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
<template>
  <div>
    <h1>Ajouter une période de travail</h1>
    <div id="userid"><input type="number" class="input" min="1" /></div>
    <br />
    <div id="start">
      <label for="start-time">Arrivée:</label>

      <input v-model="start" type="datetime-local" id="start" />
    </div>
    <br />
    <div id="end">
      <label for="endtime">Départ:</label>

      <input v-model="end" type="datetime-local" id="end" />
    </div>
    <br />
    <div id="confirm-button">
      <button @click= "createWorkingTime()" type="button" class="btn btn-primary">Confirmer</button>
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
            this.$route.params.userId +
            "?start=" +
            this.start.replace('T', ' ') + ":00" +
            "&end=" +
            this.end.replace('T', ' ') + ":00"
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
<template>
  <div>
    <h1>Liste des périodes de travail effectué</h1>

    <div>
      <h3>Selection des périodes de travail de</h3>
      <input v-model="start" type="datetime-local" id="start" />
      <h3>à</h3>
      <input v-model="end" type="datetime-local" id="end" />
    </div>

    <br />
    <div id="confirm-button">
      <button @click="getWorkingTime()" type="button" class="btn btn-primary">
        Confirmer
      </button>
    </div>
    <br />

    <ul v-if="this.info">
      <li v-for="workingtime in this.info" :key="workingtime.start">
        * {{ workingtime.start }} ==> {{ workingtime.end }} *
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ShowWorkingTime",
  data() {
    return {
      info: null,
      id: null,
    };
  },
  methods: {
    getWorkingTime() {
      axios
        .get(
          "http://localhost:4000/api/workingtimes/" +
            this.$route.params.userId +
            "?start=" +
            this.start.replace("T", " ") +
            ":00" +
            "&end=" +
            this.end.replace("T", " ") +
            ":00"
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
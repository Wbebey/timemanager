<template>
  <div>
    <h1>Edition des périodes de travail</h1>
    <div>
      <h3>Modifier une période de travail</h3>
      <input v-model="start" type="datetime-local" id="start" />
      <input v-model="end" type="datetime-local" id="end" />
    </div>
      <input v-model="id" placeholder="Entrer l'id">
    <button @click="updateWorkingTime()" type="button" class="btn btn-primary">
      Update
    </button>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "UpdateWorkingTime",
  data() {
    return {
      info: null,
      id: null,
      start: null,
      end: null,
    };
  },
  methods: {
    updateWorkingTime() {
      axios
        .put(
          `http://localhost:4000/api/workingtimes/${this.id}?start=${this.start.replace('T', ' ')}:00&end=${this.end.replace('T', ' ')}:00`
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
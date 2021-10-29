<template>
  <div>
    <h1>Delete WorkingTime !</h1>
    <input v-model="id" placeholder="Entrer l'id" />
    <button @click="deleteWorkingTime()" type="button" class="btn btn-primary">
      Delete
    </button>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "DeleteWorkingTime",
  data() {
    return {
      info: null,
      id: null,
    };
  },
  methods: {
    deleteWorkingTime() {
      axios
        .delete(`http://localhost:4000/api/workingtimes/${this.id}`)
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
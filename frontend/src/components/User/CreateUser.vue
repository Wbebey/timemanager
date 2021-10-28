<template>
  <div>
    <b-card bg-variant="dark" text-variant="white">
      <b-card-text>
        <input v-model="email" placeholder="Entrer l'email" /> <br />
        <input v-model="username" placeholder="Entrer le nom d'utilisateur" />
        <br />
        <button v-on:click="createUser()">Create User</button>
      </b-card-text>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "CreateUser",
  data() {
    return {
      info: null,
      username: null,
      email: null,
    };
  },
  methods: {
    createUser() {
      console.log(this.email);
      console.log(this.username);
      axios
        .post("http://localhost:4000/api/users/", {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          this.info = response.data;
          console.log(this.info);
          this.$router.push("/user/" + this.info.userID);
        })
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
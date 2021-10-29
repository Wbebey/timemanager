<template>
  <div>
      <v-card elevation="2" class="d-inline-flex pa-2" outlined tile>
      <v-text-field label="Adresse mail" class="mx-auto pa-6" v-model="email" />
      <v-text-field label="User ID" class="mx-auto pa-6" v-model="userID" />
      <v-text-field label="Nom d'utilisateur" class="mx-auto pa-6" v-model="username" />
      <v-btn elevation="2" outlined color="accent" v-on:click="updateUser()"
        >Update User</v-btn
      >
    </v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'UpdateUser',
  data() {
    return {
        username: null,
        email: null,
        userID: null,
    };
  },
  methods: {
    updateUser() {
      axios
        .put(`http://localhost:4000/api/users/${this.userID}/`,
        {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
  },
}
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
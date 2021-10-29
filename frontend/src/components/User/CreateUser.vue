<template>
  <div>
    <v-card elevation="2" class="d-inline-flex pa-2" outlined tile>
      <v-text-field label="Adresse mail" class="mx-auto pa-6" v-model="email"></v-text-field>
      <v-text-field
        :rules="rules"
        hide-details="auto"
        label="Nom d'utilisateur"
        class="mx-auto pa-6"
        v-model="username"
      ></v-text-field>
      <v-btn elevation="2" outlined color="accent" v-on:click="createUser()"
        >Create User</v-btn
      >
    </v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "CreateUser",
  data() {
    return {
      username: null,
      email: null,
      rules: [
        (value) => !!value || "Required.",
        (value) => (value && value.length >= 8) || "Min 8 characters",
      ],
    };
  },
  methods: {
    createUser() {
      axios
        .post("http://localhost:4000/api/users/", {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          console.log(response.data);
          this.$router.push("/user/" + response.data.id);
        })
        .catch((error) => {
          console.log("Error", error.message);
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
<template>
  <div>
    <v-card elevation="2">
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-text-field
          v-model="username"
          :counter="10"
          :rules="usernameRules"
          label="Username"
          required
        ></v-text-field>

        <v-text-field
          v-model="email"
          :rules="emailRules"
          label="E-mail"
          required
        ></v-text-field>

        <v-text-field
          v-model="password"
          :rules="passwordRules"
          label="Mot de passe"
          required
        ></v-text-field>

        <v-checkbox
          v-model="checkbox"
          :rules="[(v) => !!v || 'You must agree to continue!']"
          label="Do you agree?"
          required
        ></v-checkbox>

        <v-btn
          :disabled="!valid"
          color="success"
          class="mr-4"
          @click="validate"
        >
          Validate
        </v-btn>

        <v-btn color="error" class="mr-4" @click="reset"> Reset Form </v-btn>
      </v-form>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
//import { createCookie } from "../../cookie"

export default {
  name: "CreateUser",
  data() {
    return {
      valid: true,
      username: "",
      usernameRules: [
        (v) => !!v || "Username is required",
        (v) => (v && v.length <= 5) || "Name must be less than 5 characters",
      ],
      email: "",
      emailRules: [
        (v) => !!v || "E-mail is required",
        (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
      ],
      password: "",
      passwordRules: [
        (v) => !!v || "Password is required",
        (v) =>
          (v && v.length <= 8) || "Password must be less than 8 characters",
      ],
      checkbox: false,
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
    validate() {
      this.$refs.form.validate();
      this.createUser();
    },
    reset() {
      this.$refs.form.reset();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
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
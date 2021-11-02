<template>
  <div class="card">
    <div class="cardContent">
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-text-field
          v-model="username"
          :rules="usernameRules"
          label="Username"
          required
        ></v-text-field>

        <v-text-field
          v-model="password"
          :rules="passwordRules"
          label="Mot de passe"
          required
        ></v-text-field>

        <v-btn
          :disabled="!valid"
          color="success"
          class="mr-4"
          @click="validate"
        >
          Connection
        </v-btn>
      </v-form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
//import { createCookie } from "../../cookie"

export default {
  name: "Home",
  data() {
    return {
      valid: true,
      username: "",
      usernameRules: [
        (v) => !!v || "Username is required",
        (v) => (v && v.length <= 5) || "Name must be more than 5 characters",
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
          (v && v.length >= 8) || "Password must be more than 8 characters",
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
.cardContent {
  display: flex;
  justify-content: center;
}

.card {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
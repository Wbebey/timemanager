<template>
  <div class="page-login">
    <div class="background">
      <img :src="background" />
    </div>
    <div class="side-connection">
      <div class="page-connection">
        <img class="logo" :src="logo" />
        <div class="title-connection">Page d'enregistrement</div>
      </div>
      <div class="input-connection">
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-text-field
            class="text-field"
            v-model="username"
            :rules="usernameRules"
            label="Nom d'utilisateur"
            required
          ></v-text-field>
          <v-text-field
            class="text-field"
            v-model="email"
            :rules="emailRules"
            label="Adresse mail"
            required
          ></v-text-field>
        </v-form>
        <v-btn
          class="button-field"
          elevation="2"
          rounded
          text
          x-large
          color="white"
          @click="validate"
          ><div class="text-button">Créer un compte</div></v-btn
        >
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import background from "../assets/background.jpg";
import logo from "../assets/logo.png";

export default {
  name: "SignIn",
  data() {
    return {
      background,
      logo,
      valid: true,
      show: false,
      username: "",
      usernameRules: [
        (v) => !!v || "Le nom d'utilisateur est requis",
        (v) =>
          (v && v.length >= 3) ||
          "Le nom d'utilisateur doit être supérieur à 3 characters",
      ],
      email: "",
      emailRules: [
        (v) => !!v || "L'email est requis",
        (v) => /.+@.+\..+/.test(v) || "L'email doit être valide",
      ],
      password: "",
      passwordRules: [
        (v) => !!v || "Le mot de passe est requis",
        (v) =>
          (v && v.length >= 8) ||
          "Le mot de passe doit être supérieur à 8 characters",
      ],
      passwordConfirm: "",
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
          this.$router.push("/user/" + "1");
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

<style>
</style>
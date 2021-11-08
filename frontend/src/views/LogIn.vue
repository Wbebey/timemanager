<template>
  <div class="page-login">
    <div class="background">
      <img :src="background" />
    </div>
    <div class="side-connection">
      <div class="page-connection">
        <img class="logo" :src="logo" />
        <div class="title-connection">Time Manager</div>
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
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            :type="show ? 'text' : 'password'"
            color="white"
            class="text-field"
            v-model="password"
            :rules="passwordRules"
            label="Mot de passe"
            required
            @click:append="show = !show"
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
          ><div class="text-button">Connectez-vous</div></v-btn
        >
      </div>
    </div>
  </div>
</template>

<script>
//import axios from "axios";
import background from "../assets/background.jpg";
import logo from "../assets/logo.png";

export default {
  name: "Login",
  data() {
    return {
      background,
      logo,
      valid: true,
      show: false,
      username: "",
      usernameRules: [
        (v) => !!v || "Le nom d'utilisateur est requis",
        (v) => (v && v.length >= 3) || "Le nom d'utilisateur doit être supérieur à 3 characters",
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
          (v && v.length >= 8) || "Le mot de passe doit être supérieur à 8 characters",
      ],
      checkbox: false,
    };
  },
  methods: {
    createUser() {
      //axios
      //  .post("http://localhost:4000/api/users/", {
      //    email: this.email,
      //    username: this.username,
      //  })
      //  .then((response) => {
      //    console.log(response.data);
          this.$router.push("/user/" + "1");
      //  })
      //  .catch((error) => {
      //    console.log("Error", error.message);
      //  });
    },
    validate() {
      //this.$refs.form.validate();
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
.v-application .text-button {
    font-size: 1em !important;
    font-weight: 500;
    line-height: 2.25rem;
    letter-spacing: 0.0892857143em !important;
    font-family: "Roboto", sans-serif !important;
    text-transform: uppercase !important;
}
.theme--light.v-label {
  color: white !important;
  font-size: 1.5em;
}

.theme--light.v-input input, .theme--light.v-input textarea {
    color: white !important;;
}

.theme--light.v-text-field > .v-input__control > .v-input__slot:before {
  border-color: white !important;
}

.v-label {
  font-size: 25px;
  line-height: 1;
  min-height: 8px;
  transition: 0.3s cubic-bezier(0.25, 0.8, 0.5, 1);
}

.mdi-eye-off::before {
  content: "\F0209";
  color: white;
}

.mdi-eye::before {
  content: "\F0208";
  color: white;
}

.cardContent {
  display: flex;
  justify-content: center;
}

.card {
  display: flex;
  align-items: center;
  justify-content: center;
}

.page-login {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: row;
}

.background {
  width: 50vw;
  height: 100vh;
}

.background > img {
  height: 100%;
  width: 100%;
  object-fit: cover;
  filter: sepia(100%) hue-rotate(190deg) saturate(60%) contrast(60%)
    brightness(0.6);
  box-shadow: 0px 0px 6px;
}

.page-connection {
  height: 40vh;
  width: 100%;
  display: flex;
  align-items: center;
  justify-items: center;
  flex-direction: column;
  color: white;
  font-weight: bold;
}

.page-connection > img {
  height: 50%;
  width: auto;
  margin: auto;
}

.side-connection {
  width: 50vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #4c5c68;
}

.title-connection {
  font-size: 2em;
}

.input-connection {
  height: 30vh;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  margin-top: 5vh;
}

.text-field {
  width: 50%;
  margin: auto;
  height: 100px;
  font-size: 1.5em;
}

.button-field {
  width: 30%;
  margin: auto;
  background-color: #a24936;
}

.text-button {
  font-weight: bold;
}

.logo {
  border-radius: 90%;
}

</style>
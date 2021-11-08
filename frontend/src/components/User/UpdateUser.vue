<template>
  <v-card class="background-card">
    <v-card-title> Modification du compte </v-card-title>
    <v-card-text>
      <div class="card">
        <div class="cardContent">
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              v-model="username"
              :counter="10"
              :rules="usernameRules"
              label="Username"
              required
            />

            <v-text-field
              v-model="email"
              :rules="emailRules"
              label="E-mail"
              required
            />

            <v-text-field
              v-model="password"
              :rules="passwordRules"
              label="Mot de passe"
              required
            />

            <v-btn
              :disabled="!valid"
              color="success"
              class="mr-7"
              @click="validate"
            >
              Valider les changements
            </v-btn>

            <v-btn color="error" class="mr-7" @click="reset">
              Reset Form
            </v-btn>
          </v-form>
        </div>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from "axios";

export default {
  name: "UpdateUser",
  data() {
    return {
      valid: true,
      username: "",
      usernameRules: [
        (v) => !!v || "Username is required",
        (v) => (v && v.length <= 10) || "Name must be less than 10 characters",
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
    };
  },
  methods: {
    updateUser() {
      axios
        .put(`http://localhost:4000/api/users/${this.userID}/`, {
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
};
</script>

<style scoped>

.background-card {
  background-color: #3E4C56;
}
</style>
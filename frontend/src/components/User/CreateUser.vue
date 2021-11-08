<template>
  <div>
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Create User
        </v-card-title>

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

                <v-select
                  v-model="role"
                  :items="rolePanel"
                  :rules="[(v) => !!v || 'Select permissions']"
                  label="Permissions"
                  outlined
                ></v-select>

                <v-checkbox
                  v-model="checkbox"
                  :rules="[(v) => !!v || 'You must agree to continue!']"
                  label="Do you agree?"
                  required
                ></v-checkbox>

                <v-btn
                  :disabled="!valid"
                  color="success"
                  class="mr-7"
                  @click="validate"
                >
                  Validate
                </v-btn>

                <v-btn color="error" class="mr-7" @click="reset">
                  Reset Form
                </v-btn>
              </v-form>
            </div>
          </div>
        </v-card-text>
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
      role: "",
      rolePanel: ["Admin", "Manager", "User"],
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
  white-space: 100vh;
}
</style>
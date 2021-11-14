<template>
  <v-card class="background-card">
    <v-card-title> Modification du compte </v-card-title>
    <v-card-text>
      <div class="card">
        <div class="cardContent">
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              v-model="user.username"
              :counter="10"
              :rules="usernameRules"
              label="Username"
              required
            />

            <v-text-field
              v-model="user.email"
              :rules="emailRules"
              label="E-mail"
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

            <v-btn
              class="my-2"
              color="error"
              outlined
              fab
              small
              @click="
                ConfirmationWindow = true;
                deleteID = user.id;
              "
            >
              <v-icon>mdi-trash-can-outline </v-icon>
            </v-btn>

            <v-dialog
              v-model="ConfirmationWindow"
              max-width="350"
              persistent
              :retain-focus="false"
            >
              <v-card class="blue-grey darken-2">
                <v-card-title class="text-h5">
                  Etes-vous sur(e) de vouloir supprimer votre compte
                  ?</v-card-title
                >

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    class="mb-3"
                    depressed
                    color="grey"
                    @click="ConfirmationWindow = false"
                  >
                    Annuler
                  </v-btn>

                  <v-btn
                    class="mb-3"
                    depressed
                    color="red"
                    @click="
                      deleteUser();
                      ConfirmationWindow = false;
                    "
                  >
                    Supprimer
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-form>
        </div>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from "axios";
import store from "../../store";

export default {
  name: "UpdateUser",
  data() {
    return {
      user: [],
      valid: true,
      userID: this.$route.params.userId,
      ConfirmationWindow: false,
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
  mounted() {
    this.getUser();
  },
  methods: {
    getUser() {
      axios
        .get(`http://localhost:4000/api/users/${this.userID}`)
        .then((response) => {
          this.user = response.data;
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    validate() {
      //this.$refs.form.validate();
      this.updateUser();
    },
    updateUser() {
      axios
        .put(`http://localhost:4000/api/users/${this.userID}/`, {
          email: this.user.email,
          username: this.user.username,
        })
        .then((response) => {
          console.log("Update");
          console.log(response.data);
          this.user = response.data;
          store.state.user.username = this.user.username;
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    deleteUser() {
      axios
        .delete("http://localhost:4000/api/users/" + this.deleteID)
        .then((response) => {
          console.log(this.deleteID);
          console.log(response.data);
          this.getUser();
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
.background-card {
  background-color: #3e4c56;
}
</style>
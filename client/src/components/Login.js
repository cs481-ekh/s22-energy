import * as React from 'react';
import { useState } from "react";
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import {useNavigate} from "react-router";
import remoteFunctions from '../remote';
import {withAuthenticationRequired} from "@auth0/auth0-react";



const theme = createTheme();
function SignIn() {
    const initialValues = { email: "", password: ""};
    const [formValues, setFormValues] = useState(initialValues);
    const [formErrors, setFormErrors] = useState({});
    const [open,  setOpen] = React.useState(false);


    const handleChange = (e) => {
      const { name, value } = e.target;
      setFormValues({ ...formValues, [name]: value });
    };


    let navigate = useNavigate();
    const handleSubmit = async (event) => {
        event.preventDefault();
        const data = new FormData(event.currentTarget);
        setFormErrors(validate(formValues));

        if(validate(formValues) == true) {
            const responseJson = await remoteFunctions.getUser(data.get('email'), data.get('password'));
            console.log(responseJson);
            if (responseJson == true) {
                let path = `/admin`;
                navigate(path);
            } else {
                alert("Incorrect username or password");
            }
        }

    };

    const validate = (values) => {
      const errors = {};
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i;

      if (!values.email) {
          errors.email = "Email is required";
          if (!values.password) {
              errors.password = "Password is required";
          }
      } else if (!regex.test(values.email)) {
          errors.email = "This is not a valid email format";
          if (!values.password) {
              errors.password = "Password is required";
          }
      } else{
          return true;
      }

      setFormErrors(errors);
      return false;
    };


    const handleClickOpen = () => {
        setOpen(true);
    };

    return (
        <ThemeProvider theme={theme}>
            <Container component="main" maxWidth="xs">
                <CssBaseline />
                <Box
                    sx={{
                        marginTop: 8,
                        display: 'flex',
                        flexDirection: 'column',
                        alignItems: 'center',
                    }}
                >
                    <Avatar sx={{ m: 1, bgcolor: '#E87121' }}>
                        <LockOutlinedIcon />
                    </Avatar>
                    <Typography component="h1" variant="h5">
                        Admin Login
                    </Typography>
                    <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
                    <TextField
                        margin="normal"
                        required
                        fullWidth
                        id="email"
                        type="text"
                        name="email"
                        label="Email Address"
                        value={formValues.email}
                        onChange={handleChange}
                        />
                        <span> {formErrors.email}</span>
                        <TextField
                        margin="normal"
                        required
                        fullWidth
                        id="password"
                        label="Password"
                        type="password"
                        name="password"
                        placeholder="Password"
                        autoComplete="current-password"
                        value={formValues.password}
                        onChange={handleChange}
                        />
                        <span open={open}> {formErrors.password}</span>
                        <Button
                            type="submit"
                            fullWidth
                            variant="contained"
                            sx={{ mt: 3, mb: 2 , backgroundColor: '#E87121'}}
                            onClick={handleClickOpen}
                        >
                            Sign In
                        </Button>
                    </Box>
                </Box>
            </Container>
        </ThemeProvider>
    );
}
export default withAuthenticationRequired(SignIn, {

});

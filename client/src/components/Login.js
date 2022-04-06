import * as React from 'react';
import { useState, useEffect } from "react";
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



const theme = createTheme();
export default function SignIn() {
    const initialValues = { email: "", password: ""};
    const [formValues, setFormValues] = useState(initialValues);
    const [formErrors, setFormErrors] = useState({});
    const [isSubmit, setIsSubmit] = useState(false);
    const handleChange = (e) => {
      const { name, value } = e.target;
      setFormValues({ ...formValues, [name]: value });
    };
    let navigate = useNavigate();
    const handleSubmit = async (event) => {
        event.preventDefault();
        const data = new FormData(event.currentTarget);
        // eslint-disable-next-line no-console
        console.log({
            email: data.get('email'),
            password: data.get('password'),
        });


        const responseJson = await remoteFunctions.getUser(data.get('email'), data.get('password'));

        if(responseJson == true) {
            let path = `/admin`;
            navigate(path);
        }else{
            alert("Incorrect username or password");
        }


        setFormErrors(validate(formValues));
            setIsSubmit(true);

    };
    useEffect(() => {
      console.log(formErrors);
      if (Object.keys(formErrors).length === 0 && isSubmit) {
        console.log(formValues);
      }

    }, [formErrors]);
    const validate = (values) => {
      const errors = {};
      if (!values.email && !values.password) {
        setIsSubmit(true);
        let path = `/admin`;
        navigate(path);

      }
      const regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i;
      if (!values.email) {
        errors.email = "Email is required!";
        setIsSubmit(false);
      } else if (!regex.test(values.email)) {
        errors.email = "This is not a valid email format!";
        setIsSubmit(false);
      }
      if (!values.password) {
        errors.password = "Password is required";
        setIsSubmit(false);
      }
      return errors;
    };
    const [ setOpen] = React.useState(false);
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
                        <span> {formErrors.password}</span>
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

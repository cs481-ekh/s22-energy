import { useState, useEffect } from "react";
import * as React from 'react';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogTitle from '@material-ui/core/DialogTitle';
import DialogContentText from '@material-ui/core/DialogContentText';
import Dialog from '@material-ui/core/Dialog';

const theme = createTheme();
function SignUp() {
  const initialValues = { email: "", password: "", confirmPass: "", };
  const [formValues, setFormValues] = useState(initialValues);
  const [formErrors, setFormErrors] = useState({});
  const [isSubmit, setIsSubmit] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormValues({ ...formValues, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
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
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i;
    if (!values.email) {
      errors.email = "Email is required!";
    } else if (!regex.test(values.email)) {
      errors.email = "This is not a valid email format!";
    }
    if (!values.password) {
      errors.password = "Password is required";
    } else if (values.password.length < 4) {
      errors.password = "Password must be more than 4 characters";
    } else if (values.password.length > 10) {
      errors.password = "Password cannot exceed more than 10 characters";
    }
    if (values.password != values.confirmPass) {
        errors.confirmPass = "Password does not match";
      }
    return errors;
  };
  const [open, setOpen] = React.useState(false);
       
     
  const handleClickOpen = () => {
      setOpen(true);
    };
     const handleClose = () => {
       setOpen(false);
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
                        Sign Up
                    </Typography>
                   
                    <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
                        <TextField
                        margin="normal"
                        required
                        fullWidth
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
                        label="Password"
                        type="password"
                        name="password"
                        placeholder="Password"
                        autoComplete="current-password"
                        value={formValues.password}
                        onChange={handleChange}
                        />
                        <span> {formErrors.password}</span>
                         <TextField
                            margin="normal"
                            required
                            fullWidth
                            name="Confirm password"
                            label="Confirm password"
                            type="Confirm password"
                            id="Confirm password"
                             onChange={handleChange}
                        />
                            <span>{formErrors.confirmPass}</span>
                        <Button
                            type="submit"
                            fullWidth
                            variant="contained"
                            sx={{ mt: 3, mb: 2 , backgroundColor: '#E87121'}}
                            onClick={handleClickOpen}
                        >
                            Sign Up
                        </Button>
                        <Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
                        <DialogTitle>
                        Adding a new user !
                        </DialogTitle>
                        <DialogContent >
                        <DialogContentText>
                        Are u sure you want to add an admin user?
                        </DialogContentText>
                        </DialogContent>
                        <DialogActions>
                        <Button onClick={handleClose} color="primary">
                        Close
                        </Button>
                        <Button onClick={handleClose} color="primary" autoFocus>
                        Yes
                        </Button>
                        </DialogActions>
                        </Dialog>
                    </Box>
                </Box>
            </Container>
    </ThemeProvider>
  );
}

export default SignUp;
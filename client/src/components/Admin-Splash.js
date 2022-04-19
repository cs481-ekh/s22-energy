import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';
import {
    CardActionArea,
    Dialog,
    DialogActions,
    DialogTitle,
    Grid
} from '@mui/material';
import electric from "../imgs/Electric.jpg";
import gas from "../imgs/Natural-Gas.jpg";
import solar from "../imgs/Solar.jpg";
import admin from "../imgs/admin.jpg";
import steam from "../imgs/Steam.jpg";
import geo from "../imgs/Geothermal.jpg";

import {useNavigate} from "react-router";
import Box from "@mui/material/Box";
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import Avatar from "@mui/material/Avatar";
import Button from "@mui/material/Button";
import {withAuthenticationRequired} from "@auth0/auth0-react";
import {Auth0Lock} from "auth0-lock";



export var utility = {};
function Admin() {
    const domain = process.env.REACT_APP_AUTH0_DOMAIN;
    const clientId = process.env.REACT_APP_AUTH0_CLIENT_ID;
    const [open, setOpen] = React.useState(false);

    let navigate = useNavigate();

    var options = {
        allowSignUp: true,
        allowLogin: false,
        prefill: false,
        allowAutocomplete: false,
        allowPasswordAutocomplete: false
    };

    var lock = new Auth0Lock(clientId, domain , options);

    const signUpOnClick = () => {
        lock.show();
    };

    const electricOnClick = () => {

        setOpen(true);
    };

    const smallElecOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '2S';
    };

    const demandElecOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '2D';
    };

    const handleClose = () => {
        setOpen(false);
    };

    const gasOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '1';
    };

    const solarOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '5';
    };

    const steamOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '3';
    };

    const geoOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '4';
    };

    return (

        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                backgroundColor: '#f0f0f0',
                height: '100vh'
            }}
        >
            <Avatar sx={{ m: 1, bgcolor: '#E87121' }}>
                <AccountCircleIcon />
            </Avatar>

            <Typography component="h1" variant="h5">
                Admin Dashboard
            </Typography>

        <Grid container
              spacing={0}
              direction="row"
              align="center"

            >
            <Grid item xs>
            <Card sx={{ width: 345, marginTop: 4, marginLeft: 5, marginRight: 5}} onClick={signUpOnClick}>
                <CardActionArea>
                    <CardMedia
                        component="img"
                        height="130"
                        image={admin}
                        alt="Admin"
                    />
                    <CardContent>
                        <Typography gutterBottom variant="h5" component="div">
                            Add Admin User
                        </Typography>
                    </CardContent>
                </CardActionArea>
            </Card>
            </Grid>
            <Grid item xs>
                <Card sx={{ width: 345, marginTop: 4 , marginLeft: 5, marginRight: 5}} onClick={electricOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="130"
                            image={electric}
                            alt="Electric"
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                Upload Electric Data
                            </Typography>
                        </CardContent>
                    </CardActionArea>
                </Card>
            </Grid>
            <Dialog
                open={open}
                onClose={handleClose}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
                <DialogTitle id="alert-dialog-title">
                    {"Choose which type of electric data you would like to upload"}
                </DialogTitle>
                <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
                    <Button onClick={smallElecOnClick}>Small Electric</Button>
                    <Button onClick={demandElecOnClick} autoFocus>
                        Electric Demand
                    </Button>
                </DialogActions>
            </Dialog>
            <Grid item xs>
                <Card sx={{ width: 345, marginTop: 4 , marginLeft: 5, marginRight: 5}} onClick={gasOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="130"
                            image={gas}
                            alt="Gas"
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                Upload Gas Data
                            </Typography>
                        </CardContent>
                    </CardActionArea>
                </Card>
            </Grid>
            <Grid item xs>
                <Card sx={{ width: 345, marginTop: 4 , marginLeft: 5, marginRight: 5}} onClick={solarOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="130"
                            image={solar}
                            alt="Solar"
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                Upload Solar Data
                            </Typography>
                        </CardContent>
                    </CardActionArea>
                </Card>
            </Grid>
            <Grid item xs>
                <Card sx={{ width: 345 ,  marginTop: 4, marginLeft: 5, marginRight: 5}} onClick={steamOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="130"
                            image={steam}
                            alt="Steam"
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                Upload Steam Data
                            </Typography>
                        </CardContent>
                    </CardActionArea>
                </Card>
            </Grid>
            <Grid item xs>
                <Card sx={{ width: 345 ,  marginTop: 4, marginLeft: 5, marginRight: 5}} onClick={geoOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="130"
                            image={geo}
                            alt="Geo"
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                Upload Geothermal Data
                            </Typography>
                        </CardContent>
                    </CardActionArea>
                </Card>
            </Grid>
        </Grid>
        </Box>
    );

}

export default withAuthenticationRequired(Admin, {

});

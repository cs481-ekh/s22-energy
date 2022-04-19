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
import SmallElectric from "../imgs/SmallElectric.jpg";
import GeoThermal from "../imgs/GeoTherm.jpg";
import NaturalGas from "../imgs/NaturalGas.jpg";
import SolarCSV from "../imgs/SolarCSV.jpg";
import ElecCSV from "../imgs/ElectricDemandCSV.jpg";
import {useNavigate} from "react-router";
import Box from "@mui/material/Box";
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import Avatar from "@mui/material/Avatar";
import Button from "@mui/material/Button";
import {withAuthenticationRequired} from "@auth0/auth0-react";
import {Auth0Lock} from "auth0-lock";
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
export var utility = {};
function Admin() {
    const domain = process.env.REACT_APP_AUTH0_DOMAIN;
    const clientId = process.env.REACT_APP_AUTH0_CLIENT_ID;
    const [open, setOpen] = React.useState(false);
    const [isSolar, setSolar] = React.useState(false);
    // const [isSteam, setSteam] = React.useState(false);
    const [isSmallElectric, setSmallElectric] = React.useState(false);
    const [isElecDemand, setElecDemand] = React.useState(false);
    const [isGas, setGas] = React.useState(false);
    const [isGeo, setGeo] = React.useState(false);
    const [anchorEl, setAnchorEl] = React.useState(null);
    const openAnchor = Boolean(anchorEl);
    const handleClick = (event) => {
        setAnchorEl(event.currentTarget);
    };

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
    // Checks the CSV format for the Solar
    const GeoThermalFormatOnClick = () => {
        setGeo(true);
    };
    // Checks the CSV format for the Gas
    const GasFormatOnClick = () => {
        setGas(true);
    };
    // Checks the CSV format for the Solar
    const SolarFormatOnClick = () => {
        setSolar(true);
    };
    // Checks the CSV format for the Small Electric
    const SmallElecFormatOnClick = () => {
        setSmallElectric(true);
    };
    // Checks the CSV format for the Electric Demand
    const ElecDemandFormatOnClick = () => {
        setElecDemand(true);
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
        setAnchorEl(null);
        setGeo(false);
        setGas(false);
        setSolar(false);
        setSmallElectric(false);
        setElecDemand(false);
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
            <div>
                <Button
                    id="demo-positioned-button"
                    aria-controls={openAnchor ? 'demo-positioned-menu' : undefined}
                    aria-haspopup="true"
                    aria-expanded={openAnchor ? 'true' : undefined}
                    onClick={handleClick}
                    type="submit"
                    fullWidth
                    variant="contained"
                    sx={{ mt: 3, mb: 2 , backgroundColor: '#E87121'}}
                >
                    check csv formats
                </Button>
                <Menu
                    id="demo-positioned-menu"
                    aria-labelledby="demo-positioned-button"
                    anchorEl={anchorEl}
                    open={openAnchor}
                    onClose={handleClose}
                    anchorOrigin={{
                        vertical: 'top',
                        horizontal: 'left',
                    }}
                    transformOrigin={{
                        vertical: 'top',
                        horizontal: 'left',
                    }}
                >
                    <MenuItem onClick={GeoThermalFormatOnClick}>Geothermal Format</MenuItem>
                    <Dialog
                        maxWidth = 'lg'
                        open={isGeo}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <img src={GeoThermal}/>
                        <DialogTitle id="alert-dialog-title" align = "center">
                            {"Please make sure the CSV file is in this format"}
                        </DialogTitle>
                        <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>

                            <Button onClick={handleClose}>Close</Button>
                        </DialogActions>
                    </Dialog>
                    <MenuItem onClick={GasFormatOnClick}>Gas Format</MenuItem>
                    <Dialog
                        maxWidth = 'lg'
                        open={isGas}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <img src={NaturalGas} />
                        <DialogTitle id="alert-dialog-title" align = "center">
                            {"Please make sure the CSV file is in this format"}
                        </DialogTitle>
                        <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>

                            <Button onClick={handleClose}>Close</Button>
                        </DialogActions>
                    </Dialog>
                    <MenuItem onClick={SolarFormatOnClick}>Solar Format</MenuItem>
                    <Dialog
                        maxWidth = 'lg'
                        open={isSolar}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <img src={SolarCSV}/>
                        <DialogTitle id="alert-dialog-title" align = "center">
                            {"Please make sure the CSV file is in this format"}
                        </DialogTitle>
                        <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>

                            <Button onClick={handleClose}>Close</Button>
                        </DialogActions>
                    </Dialog>
                    <MenuItem onClick={SmallElecFormatOnClick}>SmallElec Format</MenuItem>
                    <Dialog
                        maxWidth = 'lg'
                        open={isSmallElectric}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <img src={SmallElectric} />
                        <DialogTitle id="alert-dialog-title" align = "center">
                            {"Please make sure the CSV file is in this format"}
                        </DialogTitle>
                        <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>

                            <Button onClick={handleClose}>Close</Button>
                        </DialogActions>
                    </Dialog>
                    <MenuItem onClick={ElecDemandFormatOnClick}>Electric Demand Format</MenuItem>
                    <Dialog
                        maxWidth = 'lg'
                        open={isElecDemand}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <img src={ElecCSV}/>
                        <DialogTitle id="alert-dialog-title" align = "center">
                            {"Please make sure the CSV file is in this format"}
                        </DialogTitle>
                        <DialogActions sx={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>

                            <Button onClick={handleClose}>Close</Button>
                        </DialogActions>
                    </Dialog>
                </Menu>
            </div>
        </Box>
    );
}
export default withAuthenticationRequired(Admin, {

});
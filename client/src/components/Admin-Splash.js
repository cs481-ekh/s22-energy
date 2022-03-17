import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';
import {CardActionArea, Grid} from '@mui/material';
import electric from "../imgs/Electric.jpg";
import gas from "../imgs/Natural-Gas.jpg";
import solar from "../imgs/Solar.jpg";
import admin from "../imgs/admin.jpg";
import steam from "../imgs/Steam.jpg";

import {useNavigate} from "react-router";
import Box from "@mui/material/Box";
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import Avatar from "@mui/material/Avatar";

export var utility = {};
export default function Admin() {

    let navigate = useNavigate();
    const electricOnClick = () => {
        let path = `/CsvReader`;
        navigate(path);
        utility = '2';
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

    return (

        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                marginTop: 2,
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
            <Card sx={{ width: 345, marginTop: 4}} onClick={electricOnClick}>
                <CardActionArea>
                    <CardMedia
                        component="img"
                        height="100"
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
                <Card sx={{ width: 345, marginTop: 4 }} onClick={electricOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="100"
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
            <Grid item xs>
                <Card sx={{ width: 345, marginTop: 4 }} onClick={gasOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="100"
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
                <Card sx={{ width: 345, marginTop: 4 }} onClick={solarOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="100"
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
                <Card sx={{ width: 345 , height: 200,  marginTop: 4}} onClick={steamOnClick}>
                    <CardActionArea>
                        <CardMedia
                            component="img"
                            height="100"
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
        </Grid>
        </Box>
    );

}

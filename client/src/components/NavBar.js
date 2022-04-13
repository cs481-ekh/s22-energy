import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import Container from '@mui/material/Container';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import Tooltip from '@mui/material/Tooltip';
import MenuItem from '@mui/material/MenuItem';
import logo from "../imgs/gray-logo-scaled.jpeg";
import bar from "../imgs/bar.jpeg";

import "../App.css";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import {useNavigate} from "react-router";
import {useAuth0} from "@auth0/auth0-react";


const pages = ['Map'];

function NavBar(){
    const [anchorElNav, setAnchorElNav] = React.useState(null);
    const [anchorElUser, setAnchorElUser] = React.useState(null);
    const {isAuthenticated, loginWithRedirect, logout} = useAuth0();


    const handleOpenNavMenu = (event) => {
        setAnchorElNav(event.currentTarget);
        if(isAuthenticated){
            const test = 1;
            console.log(test);
        }
    };
    const handleOpenUserMenu = (event) => {
        setAnchorElUser(event.currentTarget);
    };

    const handleCloseNavMenu = () => {
        setAnchorElNav(null);
        let path = `/map`;
        navigate(path);
    };

    let navigate = useNavigate();
    const handleCloseUserMenu = () => {
        setAnchorElUser(null);
    };

    function handleAdmin() {
        setAnchorElUser(null);
        let path = `/admin`;
        navigate(path);
    }


    return (
        <div>
            <AppBar position="static" sx={{ bgcolor: "#E5E5E5", position: 'relative', zIndex: 1251}}>
                <Container maxWidth="fixed" >
                    <Toolbar disableGutters>
                        <img src={logo} alt="logggo" className="logo" />
                        <img src={bar} alt="logggo" className="idaho-logo" />

                        <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
                            <IconButton
                                size="large"
                                aria-label="account of current user"
                                aria-controls="menu-appbar"
                                aria-haspopup="true"
                                onClick={handleOpenNavMenu}
                                color="inherit"
                            >
                            </IconButton>
                            <Menu
                                id="menu-appbar"
                                anchorEl={anchorElNav}
                                anchorOrigin={{
                                    vertical: 'bottom',
                                    horizontal: 'left',
                                }}
                                keepMounted
                                transformOrigin={{
                                    vertical: 'top',
                                    horizontal: 'center',
                                }}
                                open={Boolean(anchorElNav)}
                                onClose={handleCloseNavMenu}
                                sx={{
                                    display: { xs: 'block', md: 'none' },
                                }}
                            >
                                {pages.map((page) => (
                                    <MenuItem key={page} onClick={handleCloseNavMenu}>
                                        <Typography textAlign="center">{page}</Typography>
                                    </MenuItem>
                                ))}

                            </Menu>
                        </Box>
                        <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' } }}>

                            {pages.map((page) => (
                                <Button
                                    key={page}
                                    onClick={handleCloseNavMenu}
                                    sx={{ my: 2, color: '#E87121', display: 'block' }}
                                >
                                    {page}
                                </Button>
                            ))}


                        </Box>

                        <Box sx={{ flexGrow: 0 }}>
                            <Tooltip title="Open settings">
                                <IconButton onClick={handleOpenUserMenu} sx={{ p: 0 }}>
                                    <Avatar sx={{ m: 1, bgcolor: '#E87121' }}>
                                        <LockOutlinedIcon />
                                    </Avatar>
                                </IconButton>
                            </Tooltip>
                            <Menu
                                sx={{ mt: '45px' }}
                                id="menu-appbar"
                                anchorEl={anchorElUser}
                                anchorOrigin={{
                                    vertical: 'top',
                                    horizontal: 'right',
                                }}
                                keepMounted
                                transformOrigin={{
                                    vertical: 'top',
                                    horizontal: 'right',
                                }}
                                open={Boolean(anchorElUser)}
                                onClose={handleCloseUserMenu}
                            >
                                {!isAuthenticated && (
                                    <MenuItem onClick={() => loginWithRedirect()}>
                                        <Typography textAlign="center">Admin Login</Typography>
                                    </MenuItem>
                                )}

                                {isAuthenticated && (
                                    <MenuItem onClick={handleAdmin}>
                                        <Typography textAlign="center">Admin Page</Typography>
                                    </MenuItem>
                                )}

                                {isAuthenticated && (
                                <MenuItem onClick={() => logout()}>
                                    <Typography textAlign="center">Sign Out</Typography>
                                </MenuItem>
                                )}
                            </Menu>
                        </Box>
                    </Toolbar>
                </Container>


            </AppBar>

        </div>

    );
}
export default NavBar;

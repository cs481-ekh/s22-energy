import * as React from 'react';
import { styled, useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import CssBaseline from '@mui/material/CssBaseline';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
//import MenuIcon from '@mui/icons-material/Menu';
import { ChevronLeft, ChevronRight, ElectricalServices, PropaneTank, SolarPower, Factory } from '@mui/icons-material';
import ListItem from '@mui/material/ListItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import {Checkbox, ListItemButton} from "@mui/material";
import Button from "@mui/material/Button";
import DateComponent from "./DatePicker";

const drawerWidth = 240;

const DrawerHeader = styled('div')(({ theme }) => ({
    display: 'flex',
    alignItems: 'center',
    padding: theme.spacing(15, 1, 0, ),
    // necessary for content to be below app bar
    ...theme.mixins.toolbar,
    justifyContent: 'flex-end',
    zIndex: 1250,

}));


const filters = [
    { icon: <ElectricalServices sx={{ color: "#E87121" }} />, label: 'Electric' },
    { icon: <PropaneTank sx={{ color: "#E87121" }} />, label: 'Gas' },
    { icon: <SolarPower sx={{ color: "#E87121" }} />, label: 'Solar' },
    { icon: <Factory sx={{ color: "#E87121" }} />, label: 'Steam' },
];

// eslint-disable-next-line react/prop-types
export default function SideDrawer({startDate, setStartDate, endDate, setEndDate, utilTypes, setUtilTypes}) {
    const theme = useTheme();
    const [open, setOpen] = React.useState(false);
    const [checked, setChecked] = React.useState(utilTypes);

    const handleToggle = (value) => () => {
        const currentIndex = checked.indexOf(value);
        const newChecked = [...checked];

        if (currentIndex === -1) {
            newChecked.push(value);
        } else {
            newChecked.splice(currentIndex, 1);
        }

        // newChecked now holds utility types to be displayed
        setUtilTypes(newChecked);
        console.log(setUtilTypes);

        setChecked(newChecked);
    };

    const handleDrawerOpen = () => {
        setOpen(true);
    };

    const handleDrawerClose = () => {
        setOpen(false);
    };

    return (
        <Box sx={{ display: 'flex' }}>
            <CssBaseline />
            <Toolbar sx={ {zIndex: 1,
                position: 'absolute'}}>
                <Button
                    color="inherit"
                    aria-label="open drawer"
                    onClick={handleDrawerOpen}
                    edge="start"
                    variant="contained"
                    sx={{ mr: 2, ...(open && { display: 'none' }), bgcolor: "white", }}
                >
                    <ChevronRight sx={{color: '#E87121'}}/>
                    <Typography color="#E87121">
                        Filter by utility type
                    </Typography>
                </Button>
                
            </Toolbar>
            <Drawer
                sx={{
                    width: drawerWidth,
                    flexShrink: 0,
                    '& .MuiDrawer-paper': {
                        width: drawerWidth,
                        boxSizing: 'border-box',
                        zIndex: 1250,

                    },
                }}
                variant="persistent"
                anchor="left"
                open={open}
            >
                <DrawerHeader>
                    <IconButton onClick={handleDrawerClose}>
                        {theme.direction === 'ltr' ? <ChevronLeft sx={{color: '#E87121'}}/> : <ChevronRight />}
                    </IconButton>
                </DrawerHeader>
                <Divider />
                    <DateComponent
                        startDate={startDate}
                        setStartDate={setStartDate}
                        endDate={endDate}
                        setEndDate={setEndDate}
                    />
                    <List sx={{ width: '100%', maxWidth: 360, bgcolor: 'background.paper' }}>
                        {filters.map((value, index) => {
                            const labelId = `checkbox-list-label-${index}`;
                            return (
                                <ListItem
                                    key={index}
                                    disablePadding
                                >
                                    <ListItemButton onClick={handleToggle(index)} dense>
                                        <ListItemIcon>
                                            {value.icon}
                                            <ListItemText id={labelId} primary={`${value.label}`} sx={{ pl:"5px" }}/>
                                        </ListItemIcon>
                                    </ListItemButton>
                                    <Checkbox
                                        onClick={handleToggle(index)}
                                        checked={checked.indexOf(index) !== -1}
                                        tabIndex={-1}
                                        disableRipple
                                        inputProps={{ 'aria-labelledby': labelId }}
                                    />
                                </ListItem>
                            );
                        })}
                    </List>
                <Divider />
            </Drawer>
        </Box>
    );
}

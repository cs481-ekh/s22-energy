/* eslint-disable react/prop-types */
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
import { ChevronLeft, ChevronRight, ElectricalServices, PropaneTank, SolarPower, Factory, LightMode, FilterAlt, SquareRounded} from '@mui/icons-material';
import ListItem from '@mui/material/ListItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import {Checkbox, ListItemButton, Container} from "@mui/material";
import Button from "@mui/material/Button";
import DateComponent from "./DatePicker";
import remoteFunctions from '../remote';

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


let filters = {
    "electric": { icon: <ElectricalServices sx={{ color: "#E87121" }} />, label: 'Electric'},
    "natural_gas": { icon: <PropaneTank sx={{ color: "#E87121" }} />, label: 'Gas'},
    "solar":{ icon: <SolarPower sx={{ color: "#E87121" }} />, label: 'Solar'},
    "steam": { icon: <Factory sx={{ color: "#E87121" }} />, label: 'Steam'},
    "geothermal": {icon: <LightMode sx={{color: "#E87121"}}/>, label: 'Geothermal'}
};

// eslint-disable-next-line react/prop-types
export default function SideDrawer({startDate, setStartDate, endDate, setEndDate, setUtilTypes}) {
    const theme = useTheme();
    const [open, setOpen] = React.useState(false);
    const [utilities, setUtilities] = React.useState([]);
  
    React.useEffect(async () => {
        let utilityList = [];
        let utilIDs = [];
        let dbUtilities = await remoteFunctions.getUtlities();

        for(const utility of dbUtilities){
            let name = utility.utilityType;
            let id = utility.utilityID;
            utilIDs.push(id);
            let pushItem = {};
            if(filters[name]){
                pushItem = filters[name];
                filters[name].selected = true;
                filters[name].id = id;
                pushItem.id = id;
            }
            else{
                pushItem = {icon: <FilterAlt sx={{ color: "#E87121" }} />, 
                label: name, 
                id: id, 
                selected: true};
            }
            utilityList.push(pushItem);
        }
        setUtilities(utilityList);
        setUtilTypes(utilIDs);
    }, []);

    const handleToggle = (value) => () => {
       let listCopy = [...utilities];
       let item = listCopy.filter((item) => item.id === value.id);
       if(item){
           item[0].selected = !item[0].selected;
       }
       setUtilities(listCopy);

       let selectedUtilities = listCopy.filter((item) => item.selected);
       let ids = selectedUtilities.map((item) => item.id);
       setUtilTypes(ids);
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
                  <Container>
                    
                  <DateComponent
                        sx={{ width: '100%', bgcolor: 'background.paper' }}
                        startDate={startDate}
                        setStartDate={setStartDate}
                        endDate={endDate}
                        setEndDate={setEndDate}
                    />
                    <List sx={{ width: '100%', maxWidth: 360, bgcolor: 'background.paper' }}>
                        {utilities.map((value) => {
                            const labelId = `checkbox-list-label-${value.id}`;
                            return (
                                <ListItem
                                    key={value.id}
                                    disablePadding = {true}
                                >
                                    <ListItemButton onClick={handleToggle(value)} dense
                                    sx={{pl:0}}>
                                        <ListItemIcon>
                                            {value.icon}
                                            <ListItemText id={labelId} primary={`${value.label}`} sx={{ pl:"10px" }}/>
                                        </ListItemIcon>
                                    </ListItemButton>
                                    <Checkbox
                                        sx={{pl: 0, pr:0}}
                                        onClick={handleToggle(value)}
                                        checked={value.selected === true}
                                        tabIndex={-1}
                                        disableRipple
                                        inputProps={{ 'aria-labelledby': labelId }}
                                    />
                                </ListItem>
                            );
                        })}
                    </List>
                <Divider />
                      <br/>
                      <List sx={{ width: '100%', bgcolor: 'background.paper' }} dense disablePadding = {true}>
                          <ListItemText sx={{ pl: '3px' }} secondary="Energy Usage Key:"/>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                <SquareRounded sx={{ color: "#0486D8" }} />
                              </ListItemIcon>
                              <ListItemText secondary="Lowest"/>
                          </ListItem>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                  <SquareRounded sx={{ color: "#83B347" }} />
                              </ListItemIcon>
                              <ListItemText secondary="Low"/>
                          </ListItem>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                  <SquareRounded sx={{ color: "#ffbd28" }} />
                              </ListItemIcon>
                              <ListItemText secondary="Average"/>
                          </ListItem>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                  <SquareRounded sx={{ color: "#E87121" }} />
                              </ListItemIcon>
                              <ListItemText secondary="High"/>
                          </ListItem>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                  <SquareRounded sx={{ color: "#d62828" }} />
                              </ListItemIcon>
                              <ListItemText secondary="Higher"/>
                          </ListItem>
                          <ListItem disablePadding = {true}>
                              <ListItemIcon>
                                  <SquareRounded sx={{ color: "#8B0000" }} />
                              </ListItemIcon>
                              <ListItemText secondary="Highest"/>
                          </ListItem>
                      </List>
                  </Container>
                <br/>
                <Divider />
            </Drawer>
        </Box>
    );
}

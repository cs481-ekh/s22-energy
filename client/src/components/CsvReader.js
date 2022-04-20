import React, { useState } from "react";
import { usePapaParse } from "react-papaparse";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import "../CsvReader.css";
import {utility} from "./Admin-Splash";
import CssBaseline from "@mui/material/CssBaseline";
import {ThemeProvider} from "@emotion/react";
import Container from "@mui/material/Container";
import Box from "@mui/material/Box";
import {createTheme} from "@mui/material/styles";
import Avatar from "@mui/material/Avatar";
import UploadIcon from '@mui/icons-material/Upload';
import Typography from "@mui/material/Typography";
import remoteFunctions from "../modules/remote";
import {withAuthenticationRequired} from "@auth0/auth0-react";
import CircularProgress from '@mui/material/CircularProgress';
import Backdrop from '@mui/material/Backdrop';
import Alert from '@mui/material/Alert';
import IconButton from '@mui/material/IconButton';
import Collapse from '@mui/material/Collapse';
import CloseIcon from '@mui/icons-material/Close';
import CardContent from "@mui/material/CardContent";
import Card from "@mui/material/Card";
import {Grid} from "@material-ui/core";

const theme = createTheme();

const utils = ['non', 'Gas', 'Electric', 'Steam', 'Geothermal', 'Solar', 'Geothermal'];

function CsvReader() {
    const { readString } = usePapaParse();
    const [fileName, setFileName] = useState("");
    const [file, setFile] = useState("");
    const [loading, setLoading] = useState(false);
    const [isSuccess, setSuccess] = useState(false);
    const [isFail, setFail] = useState(false);

    const handleUpload = async () => {
        setLoading(true);
        await (remoteFunctions.uploadFile(file, utility)).then( result => {
                setLoading(false),
                    console.log(result);
                if(result.status == 200){
                    setSuccess(true);
                } else {
                    setFail(true);
                }
            }
        );

    };

    const handleCSVRead = (data) => {
        const file = data.target.files[0];
        console.log(fileName);
        setFileName(file.name);
        setFile(file);
        readString(file, {
            header: true,
            worker: true,
            complete: (results) => {
                console.log("---------------------------");
                console.log(results);
                console.log("---------------------------");
            },
        });
    };
    const handleClose = () => {
        setLoading(false);
    };
    return (

        <ThemeProvider theme={theme}>
            <Grid
                container
                spacing={0}
                direction="column"
                alignItems="center"
                style={{ height: '100vh', backgroundColor: '#f0f0f0'}}
            >
                <Card variant="outlined" sx={{boxShadow: 3, minWidth: '45%', justify:'center', marginTop: 15}}>
                    <CardContent>
                        <Container component="main" maxWidth="xs">
                            <CssBaseline />
                            <Box
                                sx={{
                                    margin: 3,
                                    display: 'flex',
                                    flexDirection: 'column',
                                    alignItems: 'center',
                                }}
                            >
                                <Avatar sx={{ m: 1, bgcolor: '#E87121' }}>
                                    <UploadIcon />
                                </Avatar>
                                <Typography component="h1" variant="h5" >
                                    Upload {utils[utility]} Data
                                </Typography>
                                <div className="CSV uploader" >
                                    <input
                                        id="file-upload"
                                        name="fileUpload"
                                        type="file"
                                        accept=".csv"
                                        onChange={handleCSVRead}
                                    ></input>
                                    <label htmlFor="file-upload" id="file-drag">
                            <span id="file-upload-btn" className="btn btn-primary">
                              Select a file
                            </span>
                                    </label>
                                </div>
                                <div  className="fileName">
                                    {fileName.length > 0 ? <p>Selected File: {fileName}</p> : <p >No File Selected</p>}
                                </div>
                                <div className="buttons">
                                    <Stack spacing={2} direction="row">
                                        <Button variant="contained" size="lg" o color="warning" onClick={handleUpload}>
                                            Upload
                                        </Button>
                                    </Stack>
                                </div>
                                <Backdrop
                                    sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
                                    open={loading}
                                    onClick={handleClose}
                                >
                                    <CircularProgress open={loading} color="inherit" />
                                </Backdrop>
                            </Box>

                            <Box sx={{ width: '100%' }}>
                                <Collapse in={isSuccess}>
                                    <Alert
                                        action={
                                            <IconButton
                                                aria-label="close"
                                                color="inherit"
                                                size="small"
                                                onClick={() => {
                                                    setSuccess(false);
                                                }}
                                            >
                                                <CloseIcon fontSize="inherit" />
                                            </IconButton>
                                        }
                                        sx={{ mb: 2 }}
                                    >
                                        Successful Upload!
                                    </Alert>
                                </Collapse>
                            </Box>
                            <Box sx={{ width: '100%' }}>
                                <Collapse in={isFail}>
                                    <Alert severity="error"
                                           action={
                                               <IconButton
                                                   aria-label="close"
                                                   color="inherit"
                                                   size="small"
                                                   onClick={() => {
                                                       setFail(false);
                                                   }}
                                               >
                                                   <CloseIcon fontSize="inherit" />
                                               </IconButton>
                                           }
                                           sx={{ mb: 2 }}
                                    >
                                        Failed to Upload!
                                    </Alert>
                                </Collapse>
                            </Box>
                        </Container>
                    </CardContent>
                </Card>
            </Grid>
        </ThemeProvider>

    );
}

export default withAuthenticationRequired(CsvReader, {

});

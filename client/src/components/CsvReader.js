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
import remoteFunctions from "../remote";
import {withAuthenticationRequired} from "@auth0/auth0-react";
import CircularProgress from '@mui/material/CircularProgress';
import Backdrop from '@mui/material/Backdrop';

const theme = createTheme();

const utils = ['non', 'Gas', 'Electric', 'Steam', 'Geothermal', 'Solar', 'Geothermal'];

function CsvReader() {
  const { readString } = usePapaParse();
  const [fileName, setFileName] = useState("");
  const [file, setFile] = useState("");
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(false);

  const handleUpload = async () => {
    setLoading(true);
    const response = await (remoteFunctions.uploadFile(file, utility)).then( 
      setLoading(false),setPost(response)
    );
    console.log(response);

    if(response.status == 200){
      setPost(response);

    }else{
      alert('Failed to upload');
    }
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
    setPost(false);
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
              open={post}
              onClick={handleClose}
            >
        <CircularProgress open={loading} color="inherit" />
          </Backdrop>
          </Box>
        </Container>
      </ThemeProvider>

  );
}

export default withAuthenticationRequired(CsvReader, {

});


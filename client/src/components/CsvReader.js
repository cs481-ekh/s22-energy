import React, { useState } from "react";
import { usePapaParse } from "react-papaparse";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import "../CsvReader.css";
import {utility} from "./Admin-Splash";

import Container from "@mui/material/Container";
import Box from "@mui/material/Box";

import Avatar from "@mui/material/Avatar";
import UploadIcon from '@mui/icons-material/Upload';
import Typography from "@mui/material/Typography";
import remoteFunctions from "../modules/remote";
import {withAuthenticationRequired} from "@auth0/auth0-react";
import CardContent from "@mui/material/CardContent";
import Card from "@mui/material/Card";
import {Grid} from "@material-ui/core";

const utils = ['non', 'Gas', 'Electric', 'Steam', 'Geothermal', 'Solar', 'Geothermal'];

function CsvReader() {
  const { readString } = usePapaParse();
  const [fileName, setFileName] = useState("");
  const [file, setFile] = useState("");

  const handleUpload = async () => {

    const response = await remoteFunctions.uploadFile(file, utility);
    console.log(response);

    if(response.status == 200){
      //return success

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
  return (

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

              <Box
                  sx={{
                    margin: 3,
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: "center",
                    justify: "center",
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
              </Box>
            </Container>
          </CardContent>
        </Card>
          </Grid>

  );
}

export default withAuthenticationRequired(CsvReader, {

});


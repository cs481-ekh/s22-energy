import React, { useState } from "react";
import { usePapaParse } from "react-papaparse";
import axios from "axios";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faDownload } from "@fortawesome/free-solid-svg-icons";
import "../CsvReader.css";
import {utility} from "./Admin-Splash";

function CsvReader() {
  const { readString } = usePapaParse();
  const [data, setData] = useState(null);
  const [fileName, setFile] = useState("");

  const handleUpload = () => {
    axios
      .post("/api/upload", {
        data: data,
      })
      .catch((err) => {
        console.log(err);
      });

  };

  const handleReset = () => {
    axios
      .post("/api/reset")
      .catch((err) => {
        console.log(err);
      });
  };

  const handleCSVRead = (data) => {
    const file = data.target.files[0];
    console.log(fileName);
    setFile(file.name);
    readString(file, {
      header: true,
      worker: true,
      complete: (results) => {
        setData(results.data);
        console.log("---------------------------");
        console.log(results);
        console.log("---------------------------");
      },
    });
  };
  return (
    <>
      <div className="CSV uploader">
        <input
          id="file-upload"
          name="fileUpload"
          type="file"
          accept=".csv"
          onChange={handleCSVRead}
        ></input>
        <label htmlFor="file-upload" id="file-drag">
          <div id="start">
            <FontAwesomeIcon
              icon={faDownload}
              size="3x"
              className="fa fa-download"
            />
            <div>Select a file or drag here {utility}</div>
          </div>
          <span id="file-upload-btn" className="btn btn-primary">
            Select a file
          </span>
        </label>
        <br />
      </div>
      <div  className="fileName">
        {fileName.length > 0 ? <p>Selected File: {fileName}</p> : <p >No File Selected</p>}
      </div>
      <div className="buttons">
        <Stack spacing={2} direction="row">
          <Button variant="contained" size="lg" o color="warning" onClick={handleUpload}>
            Upload
          </Button>
          <Button variant="outlined" size="lg" o color="warning"  onClick={handleReset}>
            Reset Data
          </Button>
        </Stack>
      </div>
    </>
  );
}

export default CsvReader;

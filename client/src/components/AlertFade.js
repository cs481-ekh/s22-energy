/* eslint-disable react/prop-types */
import React from "react";
import { Alert, Slide, IconButton } from "@mui/material";
import {Close} from "@mui/icons-material";


const AlertFadeComponent = ({
  open,
  setOpen,
  containerRef,
  severity,
  message,
  sx,
}) => {
  return (
    <Slide
      direction="up"
      timeout={500}
      in={open}
      container={containerRef.current}
    >
      <Alert
        sx={{ ...sx }}
        severity={severity}
        variant={"filled"}
        action={
          <IconButton
            aria-label="close"
            color="inherit"
            size="small"
            onClick={() => {
              setOpen(false);
            }}
          >
            <Close fontSize="inherit" />
          </IconButton>
        }
      >
        {message}
      </Alert>
    </Slide>
  );
};
export default AlertFadeComponent;

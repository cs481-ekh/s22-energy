import * as React from 'react';
import DateFnsAdapter from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';
import DatePicker from "@mui/lab/DatePicker";
import { Stack, TextField, Container } from '@mui/material';

// eslint-disable-next-line react/prop-types
const DateComponent = ({startDate, setStartDate, endDate, setEndDate}) => {
  return (
    <LocalizationProvider dateAdapter={DateFnsAdapter}>
        <Container maxWidth="sm" sx ={{mt:2}}>
        <Stack spacing={3}>
        <DatePicker
        label="Start Date"
        value={startDate}
        onChange={(newValue) =>{
            setStartDate(newValue);
        }}
        renderInput={(params) => <TextField
            {...params}>
            </TextField>}
        
        />
        <DatePicker
        label="End Date"
        value={endDate}
        onChange={(newValue) =>{
            setEndDate(newValue);
        }}
        renderInput={(params) => <TextField
            {...params}>
            </TextField>}
        
        />
        </Stack>
        </Container>
        
    </LocalizationProvider>
  );
}; 

export default DateComponent;

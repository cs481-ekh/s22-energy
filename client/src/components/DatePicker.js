import * as React from 'react';
import DateFnsAdapter from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';
import DatePicker from "@mui/lab/DatePicker";
import { Stack, TextField} from '@mui/material';

// eslint-disable-next-line react/prop-types
const DateComponent = ({ startDate, setStartDate, endDate, setEndDate }) => {
    return (
        <LocalizationProvider dateAdapter={DateFnsAdapter}>
                <Stack spacing={3} sx={{mt:2}}>
                    <DatePicker
                        label="Start Date"
                        value={startDate}
                        onChange={(newValue) => {
                            setStartDate(newValue);
                        }}
                        renderInput={(params) => <TextField
                            {...params}>
                        </TextField>}

                    />
                    <DatePicker
                        label="End Date"
                        value={endDate}
                        onChange={(newValue) => {
                            setEndDate(newValue);
                        }}
                        renderInput={(params) => <TextField
                            {...params}>
                        </TextField>}

                    />
                </Stack>
          

        </LocalizationProvider>
    );
}; 

export default DateComponent;

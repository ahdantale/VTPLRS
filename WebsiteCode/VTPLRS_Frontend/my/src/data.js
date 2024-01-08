const currentdate = new Date();
const date = currentdate.getDay() + "-" + currentdate.getMonth() + "-" + currentdate.getFullYear();
const time = currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();

const data = [{
    vno: "MH 30 FZ 3333",
    area: "Sai Mandir, Wardha Road",
    time: time,
    date: date,
    location: [21.157393, 79.008615]
},
{
    vno: "MH 30 FZ 3333",
    area: "Gittikhadan",
    time: "17:12:03",
    date: "15-05-2021",
    location: [21.165507, 79.050773]
},
{
    vno: "MH 30 FZ 3333",
    area: "Vayusena Nagar",
    time: "12:32:45",
    date: "10-05-2021",
    location: [21.165507, 79.050773]
},
{
    vno: "MH 30 FZ 3333",
    area: "Gohni, Maharashtra",
    time: "10:24:15",
    date: "02-05-2021",
    location: [20.202864, 78.143039]
}
]

export default data
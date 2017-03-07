function uppodEvent(playerID,event) {

    TestEvents(event);
    switch(event){

        case 'init':

            break;

        case 'start':

            break;

        case 'play':

            break;

        case 'pause':

            break;

        case 'stop':

            break;

        case 'seek':

            break;

        case 'loaded':

            break;

        case 'end':

            break;

        case 'download':

            break;

        case 'quality':

            break;

        case 'error':

            break;

        case 'ad_end':

            break;

        case 'pl':

            break;

        case 'volume':

            break;
    }

}



function uppodSend(playerID,com,callback) {
    document.getElementById(playerID).sendToUppod(com);
}



function uppodGet(playerID,com,callback) {
    return document.getElementById(playerID).getUppod(com);
}


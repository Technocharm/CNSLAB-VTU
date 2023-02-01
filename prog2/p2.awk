BEGIN{
    count=0;
}{
    if($1=="d"){
        count++;
    }
}
END{
    printf("Packets dropped are : %d\n",count);
}
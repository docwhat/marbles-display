# syntax=docker/dockerfile:1

# A bunch of common desktop linuxes.

############################
FROM ubuntu:latest as ubuntu

RUN apt update

############################
FROM fedora:latest as fedora

RUN dnf install -y ncurses

############################
FROM alpine:latest as alpine

RUN apk add bash

############################
FROM debian:latest as debian

RUN apt update

# EOF
